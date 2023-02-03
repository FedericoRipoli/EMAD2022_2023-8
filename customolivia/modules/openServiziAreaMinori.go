package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaMinoriTag = "openserviceareaminoripage"

func OpenServiceAreaMinoriReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREAMINORI",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaMinoriTag, response
	}
	return OpenServiceAreaMinoriTag, string(b)
}
