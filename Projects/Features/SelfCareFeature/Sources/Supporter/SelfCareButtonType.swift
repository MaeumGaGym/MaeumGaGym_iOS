import UIKit

import DSKit

public enum SelfCareButtonType {
    case plusRoutine
    case deleteRotine
    case editRoutine
    case posturePlus
    case edit
    case complete
    case plusTarget

    var buttonImage: UIImage? {
        switch self {
        case .plusRoutine:
            return DSKitAsset.Assets.selfCarePlus.image
        case .deleteRotine:
            return DSKitAsset.Assets.selfCareTrash.image
        case .editRoutine:
            return DSKitAsset.Assets.selfCarePencil.image
        case .posturePlus:
            return DSKitAsset.Assets.selfCarePlus.image
        case .plusTarget:
            return DSKitAsset.Assets.selfCarePlus.image
        default:
            return nil
        }
    }

    var text: String {
        switch self {
        case .plusRoutine:
            return "루틴 추가하기"
        case .deleteRotine:
            return "루틴 삭제"
        case .editRoutine:
            return "루틴 수정"
        case .posturePlus:
            return "자세 추가"
        case .edit:
            return "수정하기"
        case .complete:
            return "완료"
        case .plusTarget:
            return "목표 추가하기"
        }
    }

    var textColor: UIColor {
        switch self {
        case .plusRoutine:
            return .white
        case .deleteRotine:
            return .black
        case .editRoutine:
            return .white
        case .posturePlus:
            return .black
        case .edit:
            return .white
        case .complete:
            return .white
        case .plusTarget:
            return .white
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .plusRoutine:
            return DSKitAsset.Colors.blue500.color
        case .deleteRotine:
            return DSKitAsset.Colors.gray50.color
        case .editRoutine:
            return DSKitAsset.Colors.blue500.color
        case .posturePlus:
            return DSKitAsset.Colors.gray50.color
        case .edit:
            return DSKitAsset.Colors.blue500.color
        case .complete:
            return DSKitAsset.Colors.blue500.color
        case .plusTarget:
            return DSKitAsset.Colors.blue500.color
        }
    }
}
