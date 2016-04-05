# JKid - Human friendly JSON print and input.

this was made for Netiety.

JKid will colorize your JSON, it will optimize output in two ways: by removing quotation marks and by wrapping intelligently.

Fire an issue if you have an issue.

Example usage:

```js

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

```

![screenshot](http://exebook.github.io/jkid/screenshot.png)

