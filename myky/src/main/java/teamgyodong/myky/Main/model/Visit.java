package teamgyodong.myky.Main.model;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Visit {
    private Long visitId;
    private String ipAddress;
    private String userAgent;
    private String referer;
    private LocalDateTime accessTime;
}
