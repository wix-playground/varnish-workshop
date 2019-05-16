import std;

sub vcl_backend_response {
	
	if (std.integer(beresp.http.content-length, 0) >= 1500) {
		set beresp.ttl = 24h;
	} elseif (std.integer(beresp.http.content-length, 0) < 500) {
		set beresp.uncacheable = true;
	} else {
		set beresp.ttl = 60s;
	}

}
