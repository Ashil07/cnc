BEGIN{
	nudp=0;
	ntcp=0;
	tsize=0;
	starttime=0;
	stoptime=0;
	thrput=0;
}
{
	type=$5;
	event=$1;
	time=$2;
	size=$6;
	
	if (event=="+"){
		if(time<starttime){
			starttime=time;
		}
	}
	if (event=="r"){
		if(time>stoptime){
			stoptime=time;
		}
		tsize+=size;
	}
	if (type=="tcp"){
		ntcp++;
	}
	if(type=="cbr"){
		nudp++;
	}
}
END{
	thrput=(tsize/(stoptime-starttime))*(8/1000);
	printf("\nNumber of tcp packets: %d\n",ntcp);
	printf("Number of udp packets: %d\n",nudp);
	printf("Throughput: %d\n",thrput);
}	
	
	
	
