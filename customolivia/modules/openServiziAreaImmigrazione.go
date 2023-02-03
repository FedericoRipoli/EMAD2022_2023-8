package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaImmigrazioneTag = "openserviceareaimmigrazionepage"

func OpenServiceAreaImmigrazioneReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREAIMMIGRAZIONE",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaImmigrazioneTag, response
	}
	return OpenServiceAreaImmigrazioneTag, string(b)
}
