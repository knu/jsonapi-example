object false

attributes :id
node(:type) { 'article' }

node(:attributes) { |a|
  a.slice(:title, :content)
}
