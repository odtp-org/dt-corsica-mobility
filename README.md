# dt-corsica-mobility

This is a prototype on how to share a DT. 

graph LR
    SwitchDatabase[Switch Database] --> EqasimDataloader[Eqasim Dataloader]

    subgraph ODTP
        EqasimDataloader --> Eqasim
        Eqasim --> EqasimMatsim[Eqasim-Matsim]
        EqasimDataloader --> EqasimMatsim
        EqasimMatsim --> TravelDataDashboard[Travel Data Dashboard]
    end

## Tutorial

1. Clone this repository
2. Edit `dt-corsica/001.parameters` with the switch link that contains the original dataset. 
3. Edit `dt-corsica/004.secrets` with the github secrets in order to retrieve the travel data dashboard private repository. 
4. Edit `dt-corsica-mobility.sh` with the ODTP user email 
5. Run the bash script: `bash dt-corsica-mobility.sh`