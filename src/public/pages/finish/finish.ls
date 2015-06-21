$ !->
  t = 4
  set-interval count,1000
  !function count
    if t is 0
      location.href = '/host#host'
    else
      $ '#second' .text t
      t--
