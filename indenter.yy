➮ new_writer width tab_size {

tab ∆ 0
pad ∆ [tab] txt ∆ [[]]  hue ∆ [[]]

$ {
	get_width: ➮ - {
		$ width
	},
	hue: ➮ - {
	},
	cur_space: ➮ - {
		w ∆ width - tab
		t ∆ txtꕉ
		i ► t  w -= i↥
		$ w
	},
	write: ➮ - color {
		A ∆ __argarr
		A ⬉
		t ∆ txtꕉ
		c ∆ hueꕉ
		a ► A {
			a = a≂
			C ∆ ⚫cur_space()
			⌥ C < a↥ {
				⚫newl()
				t = txtꕉ
				c = hueꕉ
			}
			t ⬊ a
			c ⬊ color//(⍽(⚂ * 5))
		}
	},
	newl: ➮ - {
		pad ⬊ tab
		txt ⬊ ([])
		hue ⬊ ([])
	},
	in: ➮ - {
		⚫newl()
		tab += tab_size
		padꕉ = tab
	},
	out: ➮ - {
		tab -= tab_size
		⚫newl()
	},
	end: ➮ {
		R ∆ []
		i ⬌ txt {
			s ∆ ''
			⧖ s↥ < padⁱ { s += ' '}
			line ∆ txtⁱ  clr ∆ hueⁱ
			x ⬌ line {
				s += color(clrˣ) + lineˣ
			}
			R ⬊ s
		}
		$ R ⫴ '\n' + colorEnd(7)
	}
}
	
}

➮ test {
	w ∆ new_writer(12, 2)
	w.write.apply(w,[0,1,2,3,4,5,6,7,8,9,'a']⫴','⌶'')
	w.write(' ','{')
	w.in()
	w.write.apply(w,[0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']⫴','⌶'')
	w.out()
	
	w.write('}')
	w.newl()
	w.write('[')
	
	w.in()
	w.write.apply(w,[0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l','m']⫴','⌶'')
	w.newl()
	w.write.apply(w,['n','o','p','q','r','s','t','u','v','w','x','y','z']⫴','⌶'')
	w.out()
	w.write(']')
	e ∆ w.end()
	ロ e
	⚑
	w.newl()
	w.write(0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')
	w.in()
		w.write(0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9)
		w.newl()
		w.write(0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9)
	w.out()
	e ∆ w.end()
	ロ e
	⚑
}	
	
module.exports = new_writer
