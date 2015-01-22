# /usr/bin/env ruby
require 'pp'
require 'enumerator'


def encipher
  interim = transpose(ARGV[1], ARGV[3].split.join.downcase)
  final = transpose(ARGV[2], interim)
  final.split('').each_slice(5) do |slice|
    print slice.join.upcase
    print ' '
  end
  puts
end

def decipher
  interim = detranspose(ARGV[2], ARGV[3].split.join.downcase)
  final = detranspose(ARGV[1], interim)
  puts final
end
def detranspose(key, ciphertext)
  ciphertext = ciphertext.split.join.split('')
  second_key = key
  column_length = ciphertext.length/second_key.length
  extra_count = ciphertext.length % second_key.length
  
  second_key_a = []
  second_key.each_char.with_index do |c,i|
    length = column_length
    length = length + 1 if i < extra_count
    second_key_a.push [i, c, length]
  end

  sorter = ->(a,b) {
    a[1] <=> b[1]
  }
  second_key_a = second_key_a.sort &sorter

  ciphertext_a = Array.new(second_key.size) {Array.new}

  ciphertext_a.size.times do |i|
    ciphertext_a[second_key_a[i][0]] = ciphertext.shift(second_key_a[i][2])
  end
  result = ''

  (column_length+1).times do |j|
    second_key.size.to_i.times do |i|
      result = result + (ciphertext_a[i][j] || '')
    end
  end
  result
end

def transpose(key, plaintext)
  key_a = []
  key.each_char.with_index do |c, i|

    key_a.push [i, c]
  end
  sorter = ->(a,b) {
    a[1] <=> b[1]
  }
  key_a = key_a.sort &sorter

  ciphertext_a = Array.new(key_a.size) { Array.new }

  index = 0
  plaintext.each_char do |c|
    ciphertext_a[index].push c
    index = (index+1) % key_a.count
  end

  result = ''
  key_a.size.to_i.times do |i|

    result = result + ciphertext_a[key_a[i][0]].join
  end
  result
end

if ARGV[0] == 'encode'
  encipher
else
  decipher
end
