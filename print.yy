bg ∆ ➮ { $'\u001b[48;5;'+a+'m' }
endbg ∆ ➮ { $'\u001b[49m' }

COLOR_NAMES ∆ [0,21,28,200,240,134,130,39]
COLOR_NAME ∆ 1000
COLOR_STRING ∆ 202//196
COLOR_NUMBER ∆ 100
COLOR_SPACE ∆ 79
//s ∆ '' ⦙ i ► COLOR_NAMES { s += color(i) + ' ' + i } ⦙ ロ s

➮ serialize a filter opt {
	dup ∆ []
	$ serial(a, filter, opt)
	
	➮ serial a filter opt {
		⌥ ⬤ a ≟ 'object' && dup ≀ a >= 0 {
			$ { type:'str', str:'@', color: 250 }
		}
		dup ⬊ a
		⌥ !opt {opt = {}}
		// TODO: do not show {} at all!
		R ∆ []
		⌥ ⬤ a ≟ 'object' {
			⌥ a.map {
				R ⬊ { type:'str', str:'[', color: 250}
				R ⬊ { type:'in' }
				i ► a {
					R = R ꗚ serial(i)
					⌥ (i_ != a↥-1) {
						R ⬊ { type:'str', str:' ', color: 241 }
					}
				}
				R ⬊ { type:'out' }
				R ⬊ { type:'str', str:']', color: 241 }
			}
			⎇ {
				//⌥ (opt.hide_object_braces) 
				R ⬊ { type:'str', str:'{', color: 250 }
				R ⬊ { type:'in' }
				K ∆ ⚷a
				k ► K {
					R ⬊ { type: 'str', str: k+' ', color: COLOR_NAME }
					R = R ꗚ serial(aᵏ)
					⌥ (k_ != K↥-1) {
						R ⬊ { type:'str', str:' ', color: 250 }
					}
				}
				R ⬊ { type:'out' }
				//⌥ (opt.show_object_braces) 
				R ⬊ { type:'str', str:'}', color: 246 }
			}
		}
		⥹ ⬤ a ≟ 'string' {
			⌥ a ≟ ' ' {
				a = repl(a, ' ', '_')
				a = repl(a, '\t', '|')
				R ⬊ { type: 'str', str: '_', color: COLOR_SPACE }
			}
			⎇ {
				R ⬊ { type: 'str', str: a+'', color: COLOR_STRING }
			}
			//(bg(224)+ color(210)+a +colorEnd(7)+endbg())
		}
		⎇ R ⬊ { type:'str', color: COLOR_NUMBER, str: a+'' }
		$ R
	}
}

➮ jkid_print a width {
	⌥ width ≠ ∅ { arguments.callee.width = width }
	⌥ arguments.callee.width ≟ ∅ { width = 80 }
	⎇ width = arguments.callee.width
	Z ∆ serialize(a)
	new_writer ∆ ≣ './indenter'
	w ∆ new_writer(width, 2)
	
	➮ get_block_length {
		depth ∆ 0
		x ∆ a  size ∆ 0
		⧖ x < Z↥ {
			⌥ Zˣ.type ≟ 'in' { depth++ }
			⌥ Zˣ.type ≟ 'out' { depth-- }
			⌥ Zˣ.str { size += Zˣ.str↥+1 }
			⌥ depth ≟ 0 {
				$ [size, x]
			}
			x++
		}
	}
	➮ depth_color {
		C ∆ Zᶻ.color
		⌥ C ≟ COLOR_NAME {
			C = COLOR_NAMES[depth % COLOR_NAMES↥]
		}
		$ C
	}
	➮ single_line_print {
		z++
		⧗ (; z <= L¹; z++) {
			⌥ Zᶻ.type ≟ 'in' { depth++ }
			⌥ Zᶻ.str { w.write(depth_color(), Zᶻ.str, '') }
			⌥ Zᶻ.type ≟ 'out' { depth-- }
		}
	}
	inX ∆ 0  outX ∆ 0
	depth ∆ 0
	z ⬌ Z {
		⌥ Zᶻ.type ≟ 'in' {
			depth++
			L ∆ get_block_length(z)
			⌥ L⁰ <= w.cur_space() {
				single_line_print()
			}
			⥹  L⁰ <= w.get_width() {
				w.in()
				single_line_print()
				w.out()
			}
			⎇ {
				w.in()
			}
		}
		⌥ Zᶻ.str { w.write(depth_color(), Zᶻ.str, '') }
		⌥ Zᶻ.type ≟ 'out' { w.out()⦙ depth-- }
	}
	$ w.end()
}

module.exports.print = jkid_print

➮ test {
	A ∆ [
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
	
	ロ jkid_print(A)
}


