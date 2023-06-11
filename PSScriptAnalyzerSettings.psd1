@{
    IncludeRules = @(

        'PSAvoidDefaultValueSwitchParameter',
        'PSAvoidGlobalVars',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingComputerNameHardcoded',
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingEmptyCatchBlock',
        'PSAvoidUsingInvokeExpression',
        'PSAvoidUsingPositionalParameters',
        'PSAvoidUsingUserNameAndPasswordParams',
        'PSAvoidUsingWMICmdlet',
        'PSAvoidUsingWriteHost',

        'PSUseCompatibleCommands',
        'PSUseCompatibleSyntax',
        'PSUseCompatibleTypes',
        'PSAvoidLongLines',

        'PSAlignAssignmentStatement',
        'PSAvoidAlias',
        'PSAvoidAssignmentToAutomaticVariable',
        'PSAvoidDefaultTrueValueSwitchParameter',
        'PSAvoidDefaultValueForMandatoryParameter',
        'PSAvoidEmptyCatchBlock',
        'PSAvoidGlobalAliases',
        'PSAvoidGlobalFunctions',
        'PSAvoidGlobalVars',
        'PSAvoidInvokingEmptyMembers',
        'PSAvoidLongLines',
        'PSAvoidMultipleTypeAttributes',
        'PSAvoidNullOrEmptyHelpMessageAttribute',
        'PSAvoidOverwritingBuiltInCmdlets',
        'PSAvoidPositionalParameters',
        'PSAvoidReservedCharInCmdlet',
        'PSAvoidReservedParams',
        'PSAvoidSemicolonsAsLineTerminators',
        'PSAvoidShouldContinueWithoutForce',
        'PSAvoidTrailingWhitespace',
        'PSAvoidUserNameAndPasswordParams',
        'PSAvoidUsingBrokenHashAlgorithms',
        'PSAvoidUsingComputerNameHardcoded',
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingDeprecatedManifestFields',
        'PSAvoidUsingDoubleQuotesForConstantString',
        'PSAvoidUsingInvokeExpression',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingWMICmdlet',
        'PSAvoidUsingWriteHost',
        'PSClangSuppresion',
        'PSDscExamplesPresent',
        'PSDscTestsPresent',
        'PSLoggerInfo',
        'PSMisleadingBacktick',
        'PSMissingModuleManifestField',
        'PSPlaceCloseBrace',
        'PSPlaceOpenBrace',
        'PSPossibleIncorrectComparisonWithNull',
        'PSPossibleIncorrectUsageOfAssignmentOperator',
        'PSPossibleIncorrectUsageOfRedirectionOperator',
        'PSProvideCommentHelp',
        'PSReturnCorrectTypesForDSCFunctions',
        'PSUseApprovedVerbs',
        'PSUseBOMForUnicodeEncodedFile',
        'PSUseCmdletCorrectly',
        'PSUseCompatibleCmdlets',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseIdenticalMandatoryParametersDSC',
        'PSUseIdenticalParametersDSC',
        'PSUseLiteralInitializerForHashtable',
        'PSUseOutputTypeCorrectly',
        'PSUsePSCredentialType',
        'PSUseProcessBlockForPipelineCommand',
        'PSUseShouldProcessCorrectly',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns',
        'PSUseStandardDSCFunctionsInResource',
        'PSUseSupportsShouldProcess',
        'PSUseToExportFieldsInManifest',
        'PSUseUTF8EncodingForHelpFile',
        'PSUseUsingScopeModifierInNewRunspaces',
        'PSUseVerboseMessageInDSCResource',

        'PSDSC*',
        'PSAlignAssignmentStatement',
        'PSMissingModuleManifestField',
        'PSPlaceCloseBrace',
        'PSPlaceOpenBrace',
        'PSProvideCommentHelp',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSShouldProcess',
        'PSUseApprovedVerbs',
        'PSUseCmdletCorrectly',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUsePSCredentialType',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns'
    )

    Rules        = @{
        PSPlaceOpenBrace           = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace          = @{
            Enable             = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $false
            NoEmptyLineBefore  = $true
        }

        PSUseConsistentIndentation = @{
            Enable              = $true
            Kind                = 'space'
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            IndentationSize     = 4
        }

        PSUseConsistentWhitespace  = @{
            Enable                                  = $true
            CheckInnerBrace                         = $true
            CheckOpenBrace                          = $true
            CheckOpenParen                          = $true
            CheckOperator                           = $true
            CheckParameter                          = $true
            CheckPipe                               = $true
            CheckPipeForRedundantWhitespace         = $true
            CheckSeparator                          = $true
            IgnoreAssignmentOperatorInsideHashTable = $true
        }

        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }

        PSUseCorrectCasing         = @{
            Enable = $true
        }
    }
}
