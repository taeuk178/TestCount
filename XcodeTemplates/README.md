# Feature Module Templates

MVVM + Clean Architecture 패턴을 따르는 Feature Module을 자동으로 생성하는 도구 모음입니다.

## 두 가지 방식 제공

1. **CLI 스크립트** (권장) - 터미널에서 명령어로 폴더와 파일 자동 생성
2. **Xcode File Template** - Xcode GUI에서 파일 생성

## 포함된 파일

템플릿을 사용하면 다음 5개의 파일이 자동으로 생성됩니다:

1. **{FeatureName}View.swift** - SwiftUI View with ViewModel integration
2. **{FeatureName}ViewModel.swift** - @Observable ViewModel with business logic
3. **{FeatureName}UseCase.swift** - Protocol-based UseCase for clean architecture
4. **{FeatureName}Model.swift** - Codable data model
5. **{FeatureName}API.swift** - Moya TargetType API definition

---

## 방법 1: CLI 스크립트 (권장) 🚀

### 설치

터미널에서 다음 명령어 실행:

```bash
cd XcodeTemplates
./setup.sh
```

이 명령어는 `create-feature`를 `/usr/local/bin/`에 설치하여 어디서든 사용할 수 있게 합니다.

### 사용법

```bash
# 기본 사용법
create-feature FeatureName

# 특정 경로에 생성
create-feature UserProfile --path Features/Home/Feature

# API 엔드포인트 지정
create-feature UserProfile --api /rest/v1/UserProfile

# 모든 옵션 사용
create-feature ExerciseList --path Features/Home/Feature --api /rest/v1/ExerciseList
```

### 생성되는 구조

```
Features/Home/Feature/
└── ExerciseList/              # 폴더 자동 생성
    ├── ExerciseListView.swift
    ├── ExerciseListViewModel.swift
    ├── ExerciseListUseCase.swift
    ├── ExerciseListModel.swift
    └── ExerciseListAPI.swift
```

### 옵션

- `-p, --path PATH` : 생성할 경로 지정 (기본: 현재 디렉토리)
- `-a, --api ENDPOINT` : API 엔드포인트 경로 (기본: `/rest/v1/{FeatureName}`)
- `-h, --help` : 도움말 표시

---

## 방법 2: Xcode File Template

> **주의**: Xcode File Template은 폴더를 자동으로 만들지 못하고 파일만 개별적으로 생성됩니다. 폴더 구조가 필요하다면 CLI 스크립트를 사용하세요.

### 설치

```bash
cd XcodeTemplates
./install.sh
```

### 수동 설치

1. `Feature Module.xctemplate` 폴더를 다음 경로로 복사:
   ```
   ~/Library/Developer/Xcode/Templates/File Templates/Custom/
   ```

2. 디렉토리가 없다면 생성:
   ```bash
   mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/Custom
   ```

3. 템플릿 복사:
   ```bash
   cp -R "Feature Module.xctemplate" ~/Library/Developer/Xcode/Templates/File\ Templates/Custom/
   ```

## 사용 방법

1. **Xcode 재시작** (이미 실행 중인 경우)

2. **템플릿 선택**
   - File > New > File... (⌘N)
   - 아래로 스크롤하여 "Custom" 섹션 찾기
   - "Feature Module" 선택

3. **정보 입력**
   - **Feature Name**: 기능 이름 입력 (예: `UserProfile`, `ExerciseList`)
   - **API Endpoint Path**: API 엔드포인트 경로 입력 (예: `/rest/v1/UserProfile`)

4. **저장 위치 선택**
   - 프로젝트의 적절한 폴더 선택 (예: `Features/Home/Feature/`)
   - "Create" 클릭

5. **완료!** 5개의 파일이 자동으로 생성됩니다.

## 예시

### 입력

- Feature Name: `UserProfile`
- API Endpoint: `/rest/v1/UserProfile`

### 생성되는 파일

```
UserProfile/
├── UserProfileView.swift
├── UserProfileViewModel.swift
├── UserProfileUseCase.swift
├── UserProfileModel.swift
└── UserProfileAPI.swift
```

## 생성 후 할 일

### 1. Model 속성 정의

`{FeatureName}Model.swift` 파일을 열고 필요한 속성들을 추가하세요:

```swift
public struct UserProfileModel: Codable {
    public let id: String
    public let name: String
    public let email: String
    // 필요한 속성 추가...
}
```

### 2. UI 구현

`{FeatureName}View.swift` 파일의 `body` 부분에 실제 UI를 구현하세요:

```swift
if let data = viewModel.data {
    VStack(spacing: 16) {
        Text(data.name)
        Text(data.email)
        // UI 구현...
    }
    .padding()
}
```

### 3. SupabaseManager에 엔드포인트 추가 (선택)

더 깔끔한 관리를 위해 `SupabaseManager.swift`에 case를 추가할 수 있습니다:

```swift
public enum SupabaseManager {
    case appMaintenance
    case exerciseList
    case userProfile  // 새로 추가

    public var path: String {
        switch self {
        case .appMaintenance:
            return "/rest/v1/App_Maintenance"
        case .exerciseList:
            return "/rest/v1/ExerciseList"
        case .userProfile:
            return "/rest/v1/UserProfile"
        }
    }
}
```

그리고 API 파일에서 사용:

```swift
public var path: String {
    return SupabaseManager.userProfile.path
}
```

## 아키텍처 패턴

이 템플릿은 다음 패턴을 따릅니다:

```
View (SwiftUI)
    ↓
ViewModel (@Observable)
    ↓
UseCase (Protocol)
    ↓
Provider (Moya)
    ↓
API (TargetType)
```

### 주요 특징

- **@Observable**: iOS 17+ Observation framework 사용
- **Clean Architecture**: UseCase 레이어로 비즈니스 로직 분리
- **Moya**: 타입 세이프한 네트워킹 레이어
- **Dependency Injection**: UseCase를 ViewModel에 주입
- **Error Handling**: 로딩/에러 상태 관리
- **Pull-to-Refresh**: 기본 제공

## CLI vs Xcode Template 비교

| 기능 | CLI 스크립트 | Xcode Template |
|------|-------------|----------------|
| 폴더 자동 생성 | ✅ 지원 | ❌ 미지원 |
| 파일 자동 생성 | ✅ 5개 파일 | ✅ 5개 파일 |
| 사용 방법 | 터미널 명령어 | Xcode GUI |
| 경로 지정 | `--path` 옵션 | 수동 선택 |
| API 엔드포인트 | `--api` 옵션 | 입력 필드 |
| 속도 | ⚡️ 빠름 | 보통 |
| Xcode 통합 | ❌ | ✅ |
| 권장 사용 케이스 | **일반적인 사용** | Xcode 내에서만 작업할 때 |

**권장**: 대부분의 경우 **CLI 스크립트**를 사용하세요. 폴더 구조를 자동으로 만들어주고 더 빠릅니다.

---

## 제거 방법

### CLI 스크립트 제거

```bash
sudo rm /usr/local/bin/create-feature
```

### Xcode Template 제거

템플릿을 제거하려면:

```bash
rm -rf ~/Library/Developer/Xcode/Templates/File\ Templates/Custom/Feature\ Module.xctemplate
```

## 문제 해결

### 템플릿이 Xcode에 표시되지 않는 경우

1. Xcode를 완전히 종료
2. 템플릿이 올바른 경로에 있는지 확인:
   ```bash
   ls -la ~/Library/Developer/Xcode/Templates/File\ Templates/Custom/
   ```
3. Xcode 재시작

### 생성된 파일에서 컴파일 에러가 발생하는 경우

- NetworkKit 모듈이 프로젝트에 포함되어 있는지 확인
- Moya가 설치되어 있는지 확인
- SupabaseManager가 구현되어 있는지 확인

### CLI 명령어를 찾을 수 없는 경우

```bash
# 설치 확인
which create-feature

# 재설치
cd XcodeTemplates
./setup.sh
```

## 프로젝트 구조

```
XcodeTemplates/
├── Feature Module.xctemplate/    # Xcode 템플릿
│   ├── TemplateInfo.plist
│   ├── ___FILEBASENAME___View.swift
│   ├── ___FILEBASENAME___ViewModel.swift
│   ├── ___FILEBASENAME___UseCase.swift
│   ├── ___FILEBASENAME___Model.swift
│   └── ___FILEBASENAME___API.swift
├── create-feature                 # CLI 스크립트
├── setup.sh                       # CLI 전역 설치 스크립트
├── install.sh                     # Xcode 템플릿 설치 스크립트
└── README.md                      # 이 파일
```

## 기여

템플릿 개선 제안이나 버그 리포트는 언제든 환영합니다!
