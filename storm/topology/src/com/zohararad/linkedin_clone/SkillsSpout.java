package com.zohararad.linkedin_clone;

import backtype.storm.spout.SpoutOutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichSpout;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Values;
import backtype.storm.utils.Utils;

import java.util.Map;
import java.util.Random;

public class SkillsSpout extends BaseRichSpout {
  SpoutOutputCollector _collector;
  Random _rand;

  @Override
  public void open(Map conf, TopologyContext context, SpoutOutputCollector collector) {
    _collector = collector;
    _rand = new Random();
  }

  @Override
  public void nextTuple() {
    Utils.sleep(1000);
    String[] skills = new String[] {
        "Ruby",
        "HTML5",
        "Java",
        "Javascript",
        "Python",
        "MySQL",
        "PHP",
        "Mobile",
        "iOS",
        "Android",
        "CSS",
        "CSS3",
        ".NET",
        "C#",
        "Hadoop"
    };

    String skill = skills[_rand.nextInt(skills.length)];
    _collector.emit(new Values(skill));
  }

  @Override
  public void ack(Object id) {
  }

  @Override
  public void fail(Object id) {
  }

  @Override
  public void declareOutputFields(OutputFieldsDeclarer declarer) {
    declarer.declare(new Fields("skill"));
  }
}
