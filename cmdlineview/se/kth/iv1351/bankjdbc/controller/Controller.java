package se.kth.iv1351.bankjdbc.controller;

import se.kth.iv1351.bankjdbc.model.InstrumentDTO;

import java.util.ArrayList;
import java.util.List;

public class Controller {



    public Controller(){

    }

    public List<? extends InstrumentDTO> getSearchedInstruments(String parameter) {
        List<InstrumentDTO> instruments = new ArrayList<>();
        return instruments;
    }

    public List<? extends InstrumentDTO> getAllInstruments() {
        List<InstrumentDTO> instruments = new ArrayList<>();
        return instruments;
    }

    public void rentInstrument(int parseInt, int parseInt1) {
    }

    public void showRentedInstruments(int parseInt) {
    }
}
