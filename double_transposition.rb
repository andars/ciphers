#!/usr/bin/env ruby
require 'pp'
require 'enumerator'


def encipher(a, b, plaintext)
  interim = transpose(a, plaintext.upcase)
  final = transpose(b, interim)
  result = ''
  final.split('').each_slice(5) do |slice|
    result += slice.join
    result += ' '
  end
  result
end

def decipher(a, b, ciphertext)
  interim = detranspose(b, ciphertext.upcase)
  final = detranspose(a, interim)
  final
end

def detranspose(key, ciphertext)
  ciphertext = ciphertext.split.join.split('')
  column_length = ciphertext.length/key.length
  extra_count = ciphertext.length % key.length
  
  key_a = []
  key.each_char.with_index do |c,i|
    length = column_length
    length = length + 1 if i < extra_count
    key_a.push [i, c, length]
  end

  i = 0
  key_a.sort_by do |x| 
    [x, i += 1]
  end

  ciphertext_a = Array.new(key.size) {Array.new}

  ciphertext_a.size.times do |i|
    ciphertext_a[key_a[i][0]] = ciphertext.shift(key_a[i][2])
  end
  result = ''

  (column_length+1).times do |j|
    key.size.to_i.times do |i|
      result = result + (ciphertext_a[i][j] || '')
    end
  end
  result
end

def transpose(key, plaintext)
  plaintext = plaintext.split.join
  key_a = []
  key.each_char.with_index do |c, i|
    key_a.push [i, c]
  end

  i = 0
  key_a.sort_by do |x| 
    [x, i += 1]
  end

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
  puts encipher(ARGV[1], ARGV[2], ARGV[3])
else
  puts decipher(ARGV[1], ARGV[2], ARGV[3])
end
