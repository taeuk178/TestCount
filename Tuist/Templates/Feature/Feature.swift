//
//  Feature.swift
//  ProjectDescriptionHelpers
//
//  Created by Minhyun Cho on 12/5/23.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Make Feature",
    attributes: [
        nameAttribute,
    ],
    items: [
        .string(
            path: "Features/\(nameAttribute)/Feature/\(nameAttribute)View.swift",
            contents: """
                
                import Foundation
                import SwiftUI

                struct {{ name }}View: View {
                    
                    var body: some View {
                        Text("{{ name }}View")
                    }
                }
                """
        ),
        .string(
            path: "Features/\(nameAttribute)/Feature/\(nameAttribute)FactoryImpl.swift",
            contents: """
                
                import Foundation
                import SwiftUI
                import {{ name }}Interface
                
                public class {{ name }}FactoryImpl: {{ name }}Factory {
                    
                    public init() { }
                    
                    public func makeView() -> AnyView {
                        return AnyView(
                            {{ name }}View()
                        )
                    }
                }
                """
        ),
        .file(
            path: "Features/\(nameAttribute)/Project.swift",
            templatePath: "project.stencil"
		),
		.string(
			path: "Features/\(nameAttribute)/FeatureInterface/\(nameAttribute)Factory.swift",
			contents: """
                
                import Foundation
                import SwiftUI

                public protocol {{ name }}Factory {
                    func makeView() -> AnyView
                }
                """
		),
		.file(
			path: "Features/\(nameAttribute)/FeatureExample/\(nameAttribute)ExampleApp.swift",
			templatePath: "example.stencil"
		),
        .string(
            path: "Features/\(nameAttribute)/FeatureTesting/\(nameAttribute)Testing.swift",
            contents: "//My template contents of name \(nameAttribute)"
        ),
        .file(
            path: "Features/\(nameAttribute)/FeatureTests/\(nameAttribute)Tests.swift",
            templatePath: "tests.stencil"
        )
	]
)
