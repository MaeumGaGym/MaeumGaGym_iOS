import UIKit

import DSKit

public enum SelfCareResourcesService {
    public enum Assets {
        public static let leftArrow = DSKitAsset.Assets.leftBarArrow.image
        public static let cameraCancle = DSKitAsset.Assets.whiteCancel.image
        public static let camera = DSKitAsset.Assets.cameraActIcon.image
        public static let photo = DSKitAsset.Assets.imageActIcon.image
        public static let ture = DSKitAsset.Assets.turnArrow.image
        
        public static let selfCareMain = DSKitAsset.Assets.mainLogo.image
        
        public static let bage = DSKitAsset.Assets.whiteAdd.image
    }
    public enum Title {
        public static let selectPicture = "사진 선택"
        public static let selfCare = "자기관리"
        public static let introductsSelfCare = "나만의 루틴과 목표를 설정하여\n자기관리에 도전해보세요."
    }
    public enum identifier {
        public static let albumCell = "AlbumCell"
        public static let selfCareIntroductTableViewCell = "SelfCareIntroductTableViewCell"
        public static let selfCareMenuCollectionCell = "SelfCareMenuCollectionCell"
        public static let selfCareMenuTableViewCell = "SelfCareMenuTableViewCell"
        public static let selfCareProfileTableViewCell = "SelfCareProfileTableViewCell"
    }
}
