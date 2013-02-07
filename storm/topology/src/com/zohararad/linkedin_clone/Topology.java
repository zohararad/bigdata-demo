package com.zohararad.linkedin_clone;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.LocalDRPC;
import backtype.storm.drpc.DRPCSpout;
import backtype.storm.drpc.ReturnResults;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.tuple.Fields;

public class Topology {

  static private Integer _count = 0;

  // Unique Identifier for DRPC stream
  static final String REQUEST_STREAM_ID = SkillCountBolt.class.getName() + "/request-stream";

  public static void main(String[] args) throws InterruptedException {
    TopologyBuilder builder = new TopologyBuilder();
    // Use LocalDRPC in local mode
    LocalDRPC drpc = new LocalDRPC();

    // Create a DRPC spout
    DRPCSpout drpcSpout = new DRPCSpout("drpc-query", drpc);
    builder.setSpout("drpc-input", drpcSpout);

    // Set first bold in DRPC to emit tuples on a different stream
    builder.setBolt("drpc-stream", new DRPCQueryBolt(REQUEST_STREAM_ID, "args", "return-info"), 1)
        .noneGrouping("drpc-input");

    // Create random sentence spout on default stream
    builder.setSpout("skills", new SkillsSpout(), 2);

    // Add word counter bolt that receives splitted words and counts occurances
    // Note that use of allGrouping with drpc bolt to ensure it is placed before each count bolt in the toplogy
    builder.setBolt("count", new SkillCountBolt(REQUEST_STREAM_ID), 1)
        .fieldsGrouping("skills", new Fields("skill")) //place after word splitter bolt in default stream
        .allGrouping("drpc-stream", REQUEST_STREAM_ID); //place after DRPC stream change bolt in DRPC stream

    // Add DRPC return bolt that receives tuples from count bolt and returns them to DRPC
    builder.setBolt("return", new ReturnResults(), 1)
        .noneGrouping("count", REQUEST_STREAM_ID);

    Config conf = new Config();
    conf.setDebug(false);
    conf.setMaxTaskParallelism(3);

    LocalCluster cluster = new LocalCluster();
    cluster.submitTopology("skills-count", conf, builder.createTopology());

    while (_count < 30) {
      Thread.sleep(1000);
      System.out.println("+++++++++++++++++++++++++++++++++++++");
      System.out.println(drpc.execute("drpc-query", ""));
      _count++;
    }
    cluster.shutdown();
  }

}
