package it.unisa.emad.comunesalerno.sws.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;


public class NoteNotifica {
    @Getter
    @Setter
    private String subject;
    @Getter
    @Setter
    private String content;
    @Setter
    private Map<String, String> data;
    @Getter
    @Setter
    private String image;

    public Map<String, String> getData(){
        if(data==null){
            data=new HashMap<>();
        }
        return  data;
    }

}