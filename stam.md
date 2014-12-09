job scheduling / dependency (build order) problem

assuming DAG
when any node finishes, insert it to a global list. in the end, the reverse order of that list is the topological order.
http://youtu.be/AfSk24UTFS8?t=49m15s


predecessor problem (https://courses.csail.mit.edu/6.851/spring12/lectures/L11.html)
	u : all possible words in the universe
	n : words in input

	van emde boas (keep n cells with bit true/false)	O(logw)/O(loglogu)  : O(u) space
	+ hashing (high probability)						O(logw)				: O(n) space
	y-fast trees										O(logw)				: O(n) space
	fusion trees										O(logn in base w)	: O(n) space
	min													O(root of logn)		: O(n) space


optimal after mad science math:
	van emde boas : when w = O(polylog n)
	fusion trees :  when w is BIG

van emde boas
------------------
root(u) clusters of root(u) size, with a summary cluster of size root(u).
successor func - 
-	parse X to upper and lower bit halves, upper half is cluster index, lower half is index within cluster


relates to HyperLogLog DS ?
