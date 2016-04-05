var jkid = require('../jkid')


function test() {
	var A = [
		{aasd: {
			b: 'txt', q: 123,
			d: [1,2,3,4],
			a: {
				b: 'str', q: 123,
				d: [1,2,3,4]
			}
		}},
		[1,2,3],
		[1,2,3,4,5,6,7,
		8,9,10],
		{a: { b: 'data', 
			d: [1,2,3,4]}},
		{a: {
			b: 'info', 
			d: [1,2,3,4]
		}},
	]
	
	console.log(jkid.print(A))
}

test()

