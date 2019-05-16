sub vcl_recv {

    if (req.http.Foo == "bar" || req.url ~ "/api/") {
        return(pipe);
    }
    
}
