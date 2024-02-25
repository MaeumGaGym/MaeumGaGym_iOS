import UIKit

import DSKit

public enum HomeResourcesService {
    public enum Assets {
        public static let rightNVButton = DSKitAsset.Assets.settingActIcon.image
        public static let blackPlus = DSKitAsset.Assets.blackPlus.image
        public static let blackMinus = DSKitAsset.Assets.blackMinus.image
        public static let logoImageView = DSKitAsset.Assets.mainLogo.image.withRenderingMode(.alwaysOriginal)
        public static let settingIcon = DSKitAsset.Assets.settingActIcon.image
    }
    public enum Title {
        public static let help = "살려줘"
    }
    public enum identifier {
        public static let extraCollectionViewCell = "ExtraCollectionViewCell"
        public static let motivationMessageTableViewCell = "MotivationMessageTableViewCell"
        public static let stepTableViewCell = "StepTableViewCell"
        public static let routineTableViewCell = "RoutineTableViewCell"
    }
}
