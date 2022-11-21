package it.unisa.emad.comunesalerno.sws.repository.search;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class SearchCriteria {
    private String key;
    private Object value;
    private SearchOperation operation;
    private List<String> values;//Used in case of IN operator



}
