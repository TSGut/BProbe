ProbeInit[];

VerificationTest[ProbeGetGroundstate[{1, 0, 0}]
	, ProbeGetGroundstate[{1, 0, 0}]
	, TestID -> "ProbeGetGroundstate-inited"
];



ProbeInit[PauliMatrix[{1,2,3}], Probe->"Laplace"];

(* some naive tests *)
VerificationTest[ProbeGetGroundstate[{1, 0, 0}]
	, {-0.707107 + 0. I, -0.707107 + 0. I}
	, TestID -> "ProbeGetGroundstate-Laplace-1"
	, SameTest -> (Norm[#1-#2]<(10^-4)&)
];
VerificationTest[ProbeGetGroundstate[{0, 1, 0}]
	, {0. +0.707107 I,-0.707107+0. I}
	, TestID -> "ProbeGetGroundstate-Laplace-2"
	, SameTest -> (Norm[#1-#2]<(10^-4)&)
];
VerificationTest[ProbeGetGroundstate[{2, 0, 0}]
	, {-0.707107 + 0. I, -0.707107 + 0. I}
	, TestID -> "ProbeGetGroundstate-Laplace-3"
	, SameTest -> (Norm[#1-#2]<(10^-4)&)
];
VerificationTest[ProbeGetGroundstate[{1, 1, 1}]
	, {0.627963 - 0.627963 I, 0.459701 + 0. I}
	, TestID -> "ProbeGetGroundstate-Laplace-4"
	, SameTest -> (Norm[#1-#2]<(10^-4)&)
];


ProbeInit[PauliMatrix[{1,2,3}], Probe->"DiracSq"];

VerificationTest[ProbeGetGroundstate[{1, 0, 0}]
	, {0.5 + 0. I, 0.5 + 0. I, 0.5 + 0. I, 0.5 + 0. I}
	, TestID -> "ProbeGetGroundstate-DiracSq-1"
	, SameTest -> (Norm[#1-#2]<(10^-6)&)
];
VerificationTest[ProbeGetGroundstate[{0, 1, 0}]
	, {-0.5 + 0. I, 0. - 0.5 I, 0. - 0.5 I, 0.5 + 0. I}
	, TestID -> "ProbeGetGroundstate-DiracSq-2"
	, SameTest -> (Norm[#1-#2]<(10^-6)&)
];
VerificationTest[ProbeGetGroundstate[{2, 0, 0}]
	, {0.5 + 0. I, 0.5 + 0. I, 0.5 + 0. I, 0.5 + 0. I}
	, TestID -> "ProbeGetGroundstate-DiracSq-3"
	, SameTest -> (Norm[#1-#2]<(10^-6)&)
];
VerificationTest[ProbeGetGroundstate[{1, 1, 1}]
	, {0. -0.788675 I,0.288675 -0.288675 I,0.288675 -0.288675 I,0.211325 +0. I}
	, TestID -> "ProbeGetGroundstate-DiracSq-4"
	, SameTest -> (Norm[#1-#2]<(10^-6)&)
];