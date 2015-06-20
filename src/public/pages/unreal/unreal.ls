$ !->
  t = 4
  set-interval count,1000
  !function count
    if t is 0
      location.href = '/setting'
    else
      $ '#second' .text t
      t--
