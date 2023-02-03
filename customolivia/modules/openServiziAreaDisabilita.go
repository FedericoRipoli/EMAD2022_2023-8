package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaDisabilitaTag = "openserviceareadisabilitapage"

func OpenServiceAreaDisabilitaReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREADISABILITA",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaDisabilitaTag, response
	}
	return OpenServiceAreaDisabilitaTag, string(b)
}
