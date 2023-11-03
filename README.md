# Project

## Core

> 프로젝트의 기본적인 구조를 기반으로 앱을 서포터해주는 역활을 합니다.
프로젝트의 기본적인 구조를 정의하고 앱 개발을 지원하는 핵심 모듈
> 
- Error, Extenstion, BaseModel, Protocols, Utils, Type를 여기에서 정의해줍니다.
- **Error**
    - 앱 전체에서 발생할 수 있는 오류 상황을 나타내는 오류 유형을 정의하고, 이러한 오류를 처리하기 위한 메커니즘을 제공
- **Extension**
    - 확장을 사용하여 기본 데이터 타입에 대한 유용한 메서드 및 속성을 추가하고, 코드의 가독성을 향상시키며 코드 재사용성을 높입니다
- **BaseModel**
    - 모델 클래스는 앱 전반에서 사용되며, 데이터의 구조를 표현하고 데이터 처리를 단순화함
- **Protocols**
    - 프로토콜은 앱 내에서 다양한 객체 간의 상호 작용을 규제하고 표준화하는 데 사용합니다
- **Utils**
    - 유틸리티는 앱 전체에서 자주 사용되며, 코드의 중복을 피하고 작업을 단순화하는 데 도움을 줍니다
    - 날짜 및 시간 변환, 로깅, 파일 관리
- **Type**
    - 사용자 정의 데이터 타입을 정의하고, 데이터 타입 간의 변환을 다루는 역할을 수행

## Data

> 주로 데이터 액세스와 변환을 다루는 역할을 하는 모듈
> 
- Repository, Transform 클래스를 모아둡니다.
    - **Repository**
        - Repository 클래스 또는 구조체는 데이터 액세스를 처리하는 데 사용
        - 데이터베이스, 원격 서버, 로컬 파일 시스템 등과 같은 다양한 데이터 소스에서 데이터를 가져오고 저장하며, 클라이언트 코드가 데이터 소스의 세부 사항을 알 필요가 없도록 추상화
        - CRUD 작성
        - 비즈니스 로직에서 데이터 액세스를 분리합니다
    - **Transform**
        - Transform 클래스 또는 함수는 데이터 모델의 변환을 다루는 데 사용
        - 데이터를 다른 형식으로 변환하거나 필요한 데이터 모델로 변환하는 데 사용
        - ex) 외부 API의 응답을 내부 데이터 모델로 변환하거나, 데이터베이스 테이블과 데이터 모델 객체 간의 변환
        - 데이터 모델 간의 변환 및 데이터 포맷 처리를 추상화하여 클라이언트 코드에서 데이터의 구체적인 구조를 다룰 필요가 없도록 도움을 줍니다.

## Domain

> 비즈니스 로직을 구현하고 데이터를 처리하는 데 사용됩니다.
> 
- Error, Model, RepositoryInterface, Response, UseCase 클래스를 모아돕니다.
    - **Error**
        - Error 클래스 또는 타입은 응용 프로그램에서 발생할 수 있는 오류 또는 예외 상황을 처리하는 데 사용
    - **Model**
        - Model 클래스 또는 구조체는 데이터의 구조를 정의하고 데이터를 표현하는 데 사용
    - **RepositoryInterface**
        - RepositoryInterface는 데이터 액세스를 추상화하는 데 사용
        - 데이터 액세스 레이어와 비즈니스 로직 레이어 사이의 중간 역할
    - **Response**
        - Response 클래스 또는 구조체는 외부 서비스로부터 받은 응답 데이터를 파싱하고 처리하는 데 사용
    - **UseCase**
        - UseCase 클래스는 비즈니스 로직을 구현하는 데 사용
        - 이 클래스는 특정 기능 또는 사용 사례를 나타내며, 이를 위해 다양한 데이터 소스와 모델을 결합하여 작업을 수행
        - UseCase는 주로 Controller 또는 Presenter와 상호 작용하며, 비즈니스 규칙을 캡슐화하고 관리

## Maeumgajim-iOS-Demo

> 앱을 데모 용도로 실행시켜보는 곳입니다.
> 

## Maeumgajim-iOS

> 앱 자체를 배포하는 용도를 합니다.
> 

# Features
+ 수정중

# Modules

## DSKit

> 디자인시스템 + 컬러나 폰트를 여기서 입력합니다.
> 
- Lotties 파일은 여기서 사용합니다.
- Assets 파일은 여기 있습니다.
- Colors 파일 역시 여기 있습니다.
- Components 파일이 여기 있습니다.

## Networks

> 네트워크 관련 작업을 다루는 모듈
> 
- **API**
    - 이 부분은 원격 서버와의 통신을 위한 API 요청 및 응답 모델
    - 주로 HTTP 요청을 생성하고 서버로 보내며, 서버로부터 받은 데이터를 해석하여 응답 모델로 변환합니다.
    - 서버와의 상호작용을 추상화하고 API 엔드포인트, 요청 및 응답 구조를 정의하여 클라이언트 코드가 네트워크 세부 사항을 몰라도 서버와 통신할 수 있습니다.
- **Entity**
    - Entity 모듈은 서버로부터 받은 데이터를 나타내는 데이터 모델을 정의합니다
    - API에서 수신한 데이터를 클라이언트 앱에서 사용할 수 있는 형식으로 변환
- **Foundation**
    - Foundation 모듈은 네트워크 모듈의 기반을 형성합니다
    - 이 모듈은 네트워크 요청 및 응답 처리, 에러 핸들링, 로깅 및 서버와의 연결 설정과 관련된 기본적인 로직을 제공합니다
    - 네트워크 요청을 보내는 클라이언트 및 서비스 관리를 담당
- **SampleData**
    - 말그대로 **SampleData입니다**
- **Service**
    - Service 모듈은 클라이언트 앱에서 네트워크 요청을 수행하는 서비스 클래스를 정의합니다
    - 이 서비스 클래스는 API 모델 및 Foundation 모듈을 사용하여 실제 네트워크 요청을 만들고 실행합니다

## TestCore

> 주로 테스트와 UI 테스트에 관련된 유틸리티 및 도우미 클래스 및 확장을 제공하는 모듈
> 

## ThirdPartyLibs

> 라이브러리를 통합적으로 관리하는 저장소
> 
- SPM을 통해서 라이브러리를 관리하고 있습니다.
- SnapKit, Kingfisher, Then, Moya, RxMoya를 담고 있습니다.

## 모듈 구조
![image](https://github.com/MaeumGajim/MaeumGajim-iOS-Structure/assets/102890390/452b1b38-4834-488b-aa84-e0cd7bed8b27)

## **프로젝트 시작하기**

1. 터미널을 열고 다음 명령어를 차례로 실행하여 "maeumGajim" 명령어를 등록합니다:
    
    ```Swift
    cp maeumGajim.sh /usr/local/bin/maeumgajim
    chmod +x /usr/local/bin/maeumgajim
    ```
    
2. 아래 명령어를 실행하여 프로젝트를 실행할 준비를 합니다:
    
    ```Swift
    maeumGajim generate
    maeumGajim edit
    maeumGajim clean
    ```
    


해야하는 일
+  TokenManager
+  DSKit 분리
     - 모듈 확장
# MaeumGajim_iOS
