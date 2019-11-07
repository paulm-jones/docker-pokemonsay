package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
	"os/exec"
)

func main() {

	r := mux.NewRouter()
	r.HandleFunc("/{message}", RootHandler)

	port := os.Getenv("PORT")
	if port == "" {
		port = "80"
	}
	log.Printf("Listening on port %s", port)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), r))
}

func RootHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain")

	vars := mux.Vars(r)
	m := vars["message"]

	//./root/bin/pokemonsay
	out, err := exec.Command("cowsay", m).Output()
	if err != nil {
		log.Printf("An error occurred %v", err)
		w.WriteHeader(500)
	}
	_, _ = w.Write(out)
}
