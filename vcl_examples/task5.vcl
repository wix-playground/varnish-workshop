sub vcl_deliver {
	
    if (obj.hits > 0) {
        unset resp.http.X-Powered-By;
        set resp.http.Good = "Day";
    }

}
