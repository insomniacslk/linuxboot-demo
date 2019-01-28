package main

import (
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
)

var (
	useHTTPS = flag.Bool("https", false, "Use HTTPS instead of HTTP")
)

// NBPHandler it is.
func NBPHandler(w http.ResponseWriter, req *http.Request) {
	log.Printf("Handling NBP %+v", req)
	data, err := ioutil.ReadFile("nbp")
	if err != nil {
		w.Header().Set("Content-Type", "text/plain")
		io.WriteString(w, fmt.Sprintf("error: %v", err))
		return
	}
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Write(data)
}

func main() {
	flag.Parse()

	http.HandleFunc("/nbp", NBPHandler)
	var err error
	log.Print("Starting server")
	if *useHTTPS {
		err = http.ListenAndServeTLS(":443", "server.crt", "server.key", nil)
	} else {
		err = http.ListenAndServe(":80", nil)
	}
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
