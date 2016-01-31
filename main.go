package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"text/template"
)

// Default behavior. Can be changed with command line arguments.
var (
	userAgent = "graffiti"
	repeats   = 1
	verbose   = false
	dryRun    = false
	silent    = false
)

var summaryTmpl = `Text: {{.Text}}
Destination: {{.BaseURL}}
User Agent: {{.UserAgent}}
{{if (gt .Repeats 1)}}Repeats: {{.Repeats}}
{{end}}{{if .DryRun}}** Dry Run Mode **
{{end}}{{if not .Verbose}}** Use -v to switch verbose mode on **
{{end}}`

// Used in the summary template for printing
type summary struct {
	Text      string
	BaseURL   string
	UserAgent string
	Repeats   int
	DryRun    bool
	Verbose   bool
}

// Prints a summary before starting http requests.
func printSummary(text, baseURL string) {
	t, err := template.New("summary_tmpl").Parse(summaryTmpl)
	if err != nil {
		log.Fatalln(err)
	}
	err = t.Execute(os.Stdout, summary{
		Text:      text,
		BaseURL:   baseURL,
		UserAgent: userAgent,
		Repeats:   repeats,
		DryRun:    dryRun,
		Verbose:   verbose,
	})
	if err != nil {
		log.Fatalln(err)
	}
}

// 404 party, graffiti in action
func graffitiAttack(text, baseURL string) {
	graffiti := toBanner(text)
	for i := 0; i < repeats; i++ {
		for _, line := range graffiti {
			if verbose {
				fmt.Println(line)
			}
			if !dryRun {
				_, err := requestLine(baseURL + line)
				if err != nil {
					log.Fatalln(err)
				}
			}
		}
	}
}

// Single requests to a remote server. Contains a single line
// of the banner as a request path. A 404 error is expected.
func requestLine(url string) (status int, err error) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return
	}

	req.Header.Set("User-Agent", userAgent)
	resp, err := client.Do(req)
	if err != nil {
		return
	}
	defer resp.Body.Close()

	status = resp.StatusCode
	return
}

func main() {
	var (
		text        string
		destination string
	)

	// Command line Args parsing
	flag.StringVar(&text, "t", "", "Text to send to the remote server")
	flag.StringVar(&destination, "d", "", "Destination (ie: www.example.com)")
	flag.StringVar(&userAgent, "a", userAgent, "User Agent")
	flag.IntVar(&repeats, "r", repeats, "Number of times to execute")
	flag.BoolVar(&verbose, "v", verbose, "Verbose output")
	flag.BoolVar(&dryRun, "n", dryRun, "Dry Run")
	flag.BoolVar(&silent, "s", silent, "Silent or quiet mode")
	flag.Parse()

	// Configuration
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

	baseURL := "http://" + destination + "/"
	if !silent {
		printSummary(text, baseURL)
	}
	graffitiAttack(text, baseURL)
}
