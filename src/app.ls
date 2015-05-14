require! {express}
port = process.env.PORT || 3000
app = express!

app.set 'views', './views'
app.set 'view engine', 'jade'
app.listen port

console.log 'haha!'