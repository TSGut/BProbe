(* ::Package:: *)

Needs["Utilities`URLTools`"];


(* vNew > vOld: returns 1 *)
(* vNew < vOld: returns -1 *)
(* vNew == vOld: returns 0 *)

CompareVersionString[vOld_,vNew_]:= Block[{i, vlOld,vlNew},
	vlOld = ToExpression[#]& /@ StringSplit[vOld,"."];
	vlNew = ToExpression[#]& /@ StringSplit[vNew,"."];
	
	(* assume Length[vlOld] \[Equal] Length[vlNew] *)
	For[i=1,i<= Length[vlOld],i++,
		If[vlNew[[i]] > vlOld[[i]],
			Return[1];
		,
			If[vlNew[[i]] < vlOld[[i]],
				Return[-1];
			];
		];
	];
	
	Return[0];
];


GetMetaData[projectpath_]:= Block[{metadata},
	metadata = Import[FileNameJoin[{projectpath, "project.json"}], "RawJSON"];
	Return[metadata];
];



CleanUp[root_] := Block[{},
	DeleteDirectory[root, DeleteContents -> True];
];



Block[{locdir, files, root, meta, metaloc, result, json, url},

	locdir = FileNameJoin[{$UserBaseDirectory, "Applications", "BProbeM"}];

	Print["Fetch latest version url ..."];
	json = ImportString[URLFetch["https://api.github.com/repos/TSGut/BProbeM/releases/latest"],"RawJSON"];
	metafromurl = json["tag_name"];
	Print["Latest version on Server: " <> metafromurl];

	Print["Download and extract archive ..."];
	root = CreateDirectory[];
	SetDirectory[root];
	url=FetchURL["https://codeload.github.com/TSGut/BProbeM/tar.gz/"<>metafromurl];
	url=RenameFile[url,url<>".tar.gz"];
	files = ExtractArchive[url];

	root = FileNameJoin[{root, FileNames["BProbe*"][[1]]}];
	If[Not[DirectoryQ[root]],
		Print["The archive folder structure is not as expected ... Aborting."];
		Abort[];
	];
	
	(* Read meta data *)
	meta = GetMetaData[root];
	
	(* Check Mathematica Version *)
	If[$VersionNumber < ToExpression[meta["mathematica_version"]],
		Print["Your Mathematica version should at least be " <> ToString[meta["mathematica_version"]] <> " ... Aborting."];
		CleanUp[root];
		Abort[];
	];
	
	
	If[DirectoryQ[locdir], (* Is it possibly an update? *)
		metaloc = GetMetaData[locdir];
	
		If[CompareVersionString[metaloc["version"], meta["version"]] <= 0,
			Print["This package (with version equal or higher) is already installed ... Aborting."];
			Print["Current Version: " <> ToString[metaloc["version"]]];
			Print["Version to be installed: " <> ToString[meta["version"]]];
			CleanUp[root];
			Abort[];
		,
			Print["Remove older version of the package ..."];
			DeleteDirectory[locdir, DeleteContents -> True];
		];
	];
	
	Print["Installing Package ..."];
	
	If[result === $Failed,
		$Failed
	,
		locdir = CopyDirectory[root, locdir];
		
		CleanUp[root];
		Print["Package successfully installed into " <> locdir];
	];
 ];
