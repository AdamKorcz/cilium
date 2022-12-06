#/bin/bash -eu
printf "package policy\nimport _ \"github.com/AdamKorcz/go-118-fuzz-build/testing\"\n" > $SRC/cilium/pkg/policy/registerfuzzdep.go
go mod tidy && go mod vendor
mv $SRC/cilium/pkg/policy/l4_filter_test.go $SRC/cilium/pkg/policy/l4_filter_test_fuzz.go
mv $SRC/cilium/pkg/policy/policy_test.go $SRC/cilium/pkg/policy/policy_test_fuzz.go
mv $SRC/cilium/pkg/policy/rule_test.go $SRC/cilium/pkg/policy/rule_test_fuzz.go
mv $SRC/cilium/pkg/policy/selectorcache_test.go $SRC/cilium/pkg/pkg/policy/selectorcache_test_fuzz.go

compile_go_fuzzer github.com/cilium/cilium/test/fuzzing Fuzz fuzz gofuzz
compile_native_go_fuzzer github.com/cilium/cilium/pkg/monitor/format FuzzFormatEvent FuzzFormatEvent
compile_native_go_fuzzer github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2 FuzzCiliumNetworkPolicyParse FuzzCiliumNetworkPolicyParse
compile_native_go_fuzzer github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2 FuzzCiliumClusterwideNetworkPolicyParse FuzzCiliumClusterwideNetworkPolicyParse
compile_native_go_fuzzer github.com/cilium/cilium/pkg/policy FuzzTest FuzzResolveEgressPolicy
