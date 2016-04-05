➮ tokenizeUnderline {
	// '123 456_789 __qwe' -> [ '123', '456 789', '_qwe' ]
	R ∆ a ⌶ ' '
	r ⬌ R
		Rʳ = repl(repl(repl(Rʳ, '__', '\u0001'), '_', ' '), '\u0001', '_')
	$ R
}

➮ str2json {
	R ∆ {
	args:[]}
	L ∆ tokenizeUnderline(a)
	l ► L {
		⌥ l ≀ '=' > 0 {
			l = l ⌶ '='
			name ∆ l ⬉
			R[name] = l ⫴ '='
		}
		⎇ {
			R.args ⬊ l
		}
	}
	$ R
}

//ロ str2json('register login:yash kajshd')
//$

➮ json2str {
	R ∆ []
	k ∆ ⚷a
	i ⬌ k {
		s ∆ (kⁱ + '=' + a[kⁱ])
		⌥ kⁱ ≟ 'cmd' ♻
		s = repl(repl(s, '_', '__'), ' ', '_')
		R ⬊ s
	}
	$ R ⫴ ' '
}

➮ shortcuts_parse info order {
	➮ closest {
		m ∆ []
		u ► order {
			⌥ u ≀ a ≟ 0 {
				m ⬊ u
			}
		}
		$ m
	}
	K ∆ ⚷ info
	k ► K {
		long ∆ closest(k)
		⌥ long↥ > 1 {
			ロ '"'+k+'" could mean many things:', (long ⫴ ', ') + '.'
			$ ⦾
		}
		⌥ long↥ == 0 ♻
		del ∆ order ≀ (long⁰)
		order ⨄ (del, 1)
		info[long⁰] = infoᵏ
		⏀ infoᵏ
	}
	$ ⦿
}

➮ info_parse args order {
	order ∆ order ⌶ ' '
	s ∆ args ⫴ ' '
	info ∆ str2json(s)
	⌥ !shortcuts_parse(info, order) {
		ロ 'cant parse shortcuts'
		$
	}
	del ∆ 0
	i ► order {
		⌥ info.args↥ > 0 {
			info[i] ≜ info.args ⬉
			del ++
		}
	}
	order ⨄ (0, del)
	⌥ info.args↥ ≟ 0 { ⏀ info.args }
	$ info
}

➮ testall {
	➮ test {
		⌥ ⬤a ≟ 'string' {
			s ∆ str2json(a)
			ロ s
			ロ json2str(s)
		}
		⎇ ロ json2str(a)
	}
	
	test('reg yash pass')
	test("reg login:yash_niv password:pass")
}

module.exports.parse = info_parse
module.exports.string = json2str
//module.exports.info_parse = info_parse


//testall()