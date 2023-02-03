package modules

import (
	"encoding/json"
	"github.com/olivia-ai/olivia/modules/start"
)

var OpenServiceAreaAsiloNidoTag = "openserviceareaasilonidopage"

func OpenServiceAreaAsiloNidoReplacer(locale, entry, response, _ string) (string, string) {
	customActionResponse := start.CustomModuleResponse{
		Content: response,
		Action: start.AppAction{
			Type:  "OPENSERVICEAREAASILONIDO",
			Value: "",
		},
	}
	b, err := json.Marshal(customActionResponse)
	if err != nil {
		return OpenServiceAreaAsiloNidoTag, response
	}
	return OpenServiceAreaAsiloNidoTag, string(b)
}
