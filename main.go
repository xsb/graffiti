package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/xsb/graffiti/banner"
)

// Single requests to a remote server. Contains a single line
// of the banner as a request path. A 404 error is expected.
func request(url, userAgent string) {
	client := &http.Client{}

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Fatalln(err)
	}
	req.Header.Set("User-Agent", userAgent)

	resp, err := client.Do(req)
	if err != nil {
		log.Fatalln(err)
	}
	defer resp.Body.Close()

}

func main() {

	var (
		text        string
		destination string
		userAgent   string
		verbose     bool
		dryRun      bool
		silent      bool
		repeats     int
	)

	// Command line Args parsing
	flag.StringVar(&text, "t", "", "Text to send to the remote server")
	flag.StringVar(&destination, "d", "", "Destination (ie: www.example.com)")
	flag.StringVar(&userAgent, "a", "graffiti", "User Agent")
	flag.IntVar(&repeats, "r", 1, "Number of times to execute")
	flag.BoolVar(&verbose, "v", false, "Verbose output")
	flag.BoolVar(&dryRun, "n", false, "Dry Run")
	flag.BoolVar(&silent, "s", false, "Silent or quiet mode")
	flag.Parse()

	// Basic configuration
	if dryRun {
		verbose = true
	}
	if silent {
		verbose = false
	}
	if text == "" || destination == "" {
		flag.PrintDefaults()
		os.Exit(1)
	}

	graffiti := banner.Transform(text)
	baseUrl := "http://" + destination + "/"

	// Print summary
	if !silent {
		fmt.Println("Text:", "\""+text+"\"")
		fmt.Println("Destination:", baseUrl)
		fmt.Println("User Agent:", userAgent)
		if repeats > 1 {
			fmt.Println("Repeats:", repeats)
		}
		if dryRun {
			fmt.Println("** Dry Run Mode **")
		}
		if !verbose {
			fmt.Println(" ** Use -v to switch verbose mode on **")
		}
	}

	// Paint a graffiti
	for i := 0; i < repeats; i++ {
		for _, line := range graffiti {
			if verbose {
				fmt.Println(line)
			}
			if !dryRun {
				url := baseUrl + line
				request(url, userAgent)
			}
		}
	}
}
