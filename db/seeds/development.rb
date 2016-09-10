nick = Person.create(name: 'Nick', ip: '127.0.0.1')
Event.create(name: 'Noodles', date: DateTime.new(2016, 9, 6), people: [nick])
