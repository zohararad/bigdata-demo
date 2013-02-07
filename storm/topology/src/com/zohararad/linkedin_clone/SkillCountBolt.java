package com.zohararad.linkedin_clone;

import backtype.storm.topology.BasicOutputCollector;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseBasicBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Values;

import java.util.HashMap;
import java.util.Map;

public class SkillCountBolt extends BaseBasicBolt {
  Map<String, Integer> counts = new HashMap<String, Integer>();

  private String _targetStreamId;

  public SkillCountBolt(String targetStreamId) {
    _targetStreamId = targetStreamId;
  }

  @Override
  public void execute(Tuple tuple, BasicOutputCollector collector) {
    if (tuple.getSourceStreamId().equals(_targetStreamId)){
      Object retInfo = tuple.getValue(1);
      collector.emit(_targetStreamId, new Values(counts.toString(), retInfo));
    } else {
      String skill = tuple.getString(0);
      Integer count = counts.get(skill);
      if(count == null){
        count = 0;
      }
      count++;
      counts.put(skill, count);
      collector.emit(new Values(skill, count));
      //System.out.println("===========================================");
      //System.out.println(counts.toString());
    }
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    // output fields on default stream
    declarer.declare(new Fields("skill", "count"));
    // output fields on drpc stream
    declarer.declareStream(_targetStreamId, new Fields("counts", "return-info"));
  }
}
