function timerobj = runLCMVisualizer(obj,lcm_coder)
% Starts an LCM visualizer node which listens for state and draws

checkDependency('lcm_enabled');

lc = lcm.lcm.LCM.getSingleton();
aggregator = lcm.lcm.MessageAggregator();
aggregator.setMaxMessages(1);  % make it a last-message-only queue

name=lcm_coder.getRobotName();
lc.subscribe([lower(name),'_state'],aggregator);

% just draw as fast as I can...
while true
  xmsg = getNextMessage(aggregator);
  [x,t] = decodeState(lcm_coder,xmsg);
  draw(obj,t,x,[]);
end
