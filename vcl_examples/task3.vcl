sub vcl_hash {

    hash_data(req.http.X-Forwarded-Proto);

}
