#!/bin/sh
# Abinashi Dhungel : 12-01-2013

#get Parent of a node
proc getParent {i } {
	return [expr {int(floor(($i-1)/2))}] 
}

#get Left child of a node
proc getLeft { i} {
	return [expr { 2*$i + 1}]
}

#get right child of a node
proc getRight { i} {
	return [expr { 2*$i + 2}]
}

#Heapify a node - O(lg n) 
proc heapify {A i heapSize} {
	
	set largest $i
	set left [getLeft $i]
	set right [getRight $i]
	
	if {$left < $heapSize && [lindex $A $largest] < [lindex $A $left] } {
		set largest $left }
	if {$right < $heapSize && [lindex $A $largest] < [lindex $A $right] } {
		set largest $right }
		
	if { $largest != $i} {
		set temp [lindex $A $i]
		lset A $i [lindex $A $largest]
		lset A $largest $temp
		set A [heapify $A $largest $heapSize]
	}

	return $A
}

#Build a heap from a given array
proc buildHeap {A  heapSize} {
	set last [expr {$heapSize-1}]
	set plast [getParent $last]
	for {set i $plast} { $i >= 0} {incr i -1} {
		set A [heapify $A $i $heapSize]
	}
	return $A
}

#Sort A using Heapsort method
proc heapSort {A heapSize } {
	
	set A [buildHeap $A $heapSize]
	puts "the initial Heap is \n $A"

	set N [expr {[llength $A] - 1}]

	for { set i $N} { $i >= 1 } { incr i -1 }  {
		set temp [lindex $A 0]
		lset A 0 [lindex $A $i] 
		lset A [expr {$heapSize -1}] $temp

		puts "A is now $A " 

		incr heapSize -1	
		set A [heapify $A 0 $heapSize]	
	}
	return $A
}

#demo
proc start { } {
	set A {4 1 3 2 16 9 10 14 8 7}
	set heapSize [llength $A]
	set B [heapSort $A $heapSize]
}

start 
