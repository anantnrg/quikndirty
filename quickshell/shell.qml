import Quickshell
import "components"

Scope {
    id: root
    SideBar {}
    TopBar {}
    
    Corner { cornerType: RoundCorner.CornerEnum.TopLeft }
    Corner { cornerType: RoundCorner.CornerEnum.TopRight }
    Corner { cornerType: RoundCorner.CornerEnum.BottomLeft }
    Corner { cornerType: RoundCorner.CornerEnum.BottomRight }
}
