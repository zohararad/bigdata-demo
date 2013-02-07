package com.zohararad.linkedin_clone;

import backtype.storm.topology.BasicOutputCollector;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseBasicBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;

public  class DRPCQueryBolt extends BaseBasicBolt {
  private String _targetStreamId;
  private Fields _fields;

  public DRPCQueryBolt(String targetStreamId, String... fields) {
    _targetStreamId = targetStreamId;
    _fields = new Fields(fields);
  }

  @Override
  public void execute(Tuple tuple, BasicOutputCollector collector) {
    collector.emit(_targetStreamId, tuple.getValues());
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declareStream(_targetStreamId, _fields);
  }
}
