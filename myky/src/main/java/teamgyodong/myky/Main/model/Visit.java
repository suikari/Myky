package teamgyodong.myky.Main.model;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Visit {
    private int visitId;
    private String ipAddress;
    private String userAgentBrowser;
    private String userAgentWindows;
    private String referer;
    private String accessTime;
   
    private int visitCount;
    
    
    private String visitDate;
    private String visitHour;

    

}
