package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaAnzianiTag = "openserviceareaanzianipage"

func OpenServiceAreaAnzianiReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREAANZIANI",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaAnzianiTag, response
	}
	return OpenServiceAreaAnzianiTag, string(b)
}
