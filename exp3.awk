BEGIN{
	starttime=5.0;
	stoptime=0.1;
	tsize=0
	thrput=0
}
{
	size=$6;
	event=$1;
	time=$2;
	
	if (event=="+"){
		if (time<starttime){
			starttime=time;
		}
	}
	if (event=="r"){
		if(time>stoptime){
			stoptime=time;
		}
		tsize+=size;
	}
	thrput=(tsize/(stoptime-starttime))*(8/1000)
	printf("%f\t%.2f\n",time,thrput);
}
END{
	
}

