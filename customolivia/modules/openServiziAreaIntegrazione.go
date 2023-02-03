package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaIntegrazioneTag = "openserviceareaintegrazionepage"

func OpenServiceAreaIntegrazioneReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREAINTEGRAZIONE",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaIntegrazioneTag, response
	}
	return OpenServiceAreaIntegrazioneTag, string(b)
}
