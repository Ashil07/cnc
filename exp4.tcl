set val(stop) 15.0

set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open out.tr w]
$ns trace-all $tf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]

$n0 color "blue"
$n0 label "Src1"

$n1 color "blue"
$n1 label "Src2"

$n8 color "red"
$n8 label "Dst1"

$n6 color "red"
$n6 label "Dst2"

$ns make-lan "$n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7" 10Mb 10ms LL Queue/DropTail Mac/802_3
$ns duplex-link $n7 $n8 1.0Mb 1ms DropTail
$ns queue-limit $n7 $n8 5

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp 

set tcpsink [new Agent/TCPSink]
$ns attach-agent $n8 $tcpsink

$ns connect $tcp $tcpsink

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1 

set tcpsink1 [new Agent/TCPSink]
$ns attach-agent $n6 $tcpsink1

$ns connect $tcp1 $tcpsink1

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 0.5 "$ftp start"
$ns at 5.0 "$ftp stop"
$ns at 5.5 "$ftp start"
$ns at 12.0 "$ftp stop"

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.0 "$ftp1 start"
$ns at 6.0 "$ftp1 stop"
$ns at 7.0 "$ftp1 start"
$ns at 13.0 "$ftp1 stop"

set file1 [open file1.tr w]
$tcp attach $file1

set file2 [open file2.tr w]
$tcp1 attach $file2

$tcp trace cwnd_
$tcp1 trace cwnd_

proc finish {} {
	global ns nf tf 
	$ns flush-trace
	close $nf
	close $tf
	exec nam out.nam &
	exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run







