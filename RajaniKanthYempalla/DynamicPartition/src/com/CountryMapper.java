package com;

import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;

public class CountryMapper extends 
Mapper<LongWritable, Text, NullWritable, Text> {

	private MultipleOutputs<NullWritable, Text> mos;

    @Override
    public void setup(Context context) {
        mos = new MultipleOutputs<NullWritable, Text>(context);
    }           

    // 
    // You must override the cleanup method and close the multi-output object
    // or things do not work correctly.
    @Override
    protected void cleanup(Context context) throws IOException, InterruptedException {
        mos.close();
    }
	
	protected void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		String line = value.toString();
		
		System.out.println("Line ::>>> "+line);
		
		String[] words = line.split("\\|");
		
		String country = words[2];
		
		System.out.println("country ::>> "+country);
		
		String status = words[3];
		
		System.out.println("STATUS :::>>> "+status);
		
		String data = country+"/"+status;
		
		mos.write(NullWritable.get(), value,data);

	}
	
}
